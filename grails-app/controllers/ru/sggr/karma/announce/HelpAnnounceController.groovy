package ru.sggr.karma.announce

import org.springframework.dao.DataIntegrityViolationException
import ru.sggr.karma.User
import grails.plugins.springsecurity.Secured

@Secured(['ROLE_USER'])
class HelpAnnounceController {
    static scaffold = HelpAnnounce
    static allowedMethods = [create: ['GET', 'POST'], edit: ['GET', 'POST'], delete: 'POST']
    @Secured(['ROLE_ADMIN'])
    def index() {
        redirect action: 'list', params: params
    }
    @Secured(['ROLE_ADMIN'])
    def list() {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [helpAnnounceInstanceList: HelpAnnounce.list(params), helpAnnounceInstanceTotal: HelpAnnounce.count()]
    }

    def create() {
        switch (request.method) {
            case 'GET':
                [helpAnnounceInstance: new HelpAnnounce(params),developers:User.list()]
                break
            case 'POST':
                def helpAnnounceInstance = new HelpAnnounce(params)
                if (!helpAnnounceInstance.save(flush: true)) {
                    render view: 'create', model: [helpAnnounceInstance: helpAnnounceInstance,developers:User.list()]
                    return
                }
                sendMail {
                    to helpAnnounceInstance.helpedDevelopers*.email
                    subject "Помощь от "+helpAnnounceInstance.author.name
                    body( view:"/shared/mail/newHelpAnnounceMailTemplate",
                            model:[helpAnnounceInstance:helpAnnounceInstance])
                }
                flash.message = message(code: 'default.created.message', args: [message(code: 'helpAnnounce.label', default: 'HelpAnnounce'), helpAnnounceInstance.id])
                redirect action: 'show', id: helpAnnounceInstance.id
                break
        }
    }

    def show() {
        def helpAnnounceInstance = HelpAnnounce.get(params.id)
        if (!helpAnnounceInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'helpAnnounce.label', default: 'HelpAnnounce'), params.id])
            redirect action: 'list'
            return
        }

        [helpAnnounceInstance: helpAnnounceInstance]
    }

    def edit() {
        switch (request.method) {
            case 'GET':
                def helpAnnounceInstance = HelpAnnounce.get(params.id)
                if (!helpAnnounceInstance) {
                    flash.message = message(code: 'default.not.found.message', args: [message(code: 'helpAnnounce.label', default: 'HelpAnnounce'), params.id])
                    redirect action: 'list'
                    return
                }

                [helpAnnounceInstance: helpAnnounceInstance,developers:User.list()]
                break
            case 'POST':
                def helpAnnounceInstance = HelpAnnounce.get(params.id)
                if (!helpAnnounceInstance) {
                    flash.message = message(code: 'default.not.found.message', args: [message(code: 'helpAnnounce.label', default: 'HelpAnnounce'), params.id])
                    redirect action: 'list'
                    return
                }

                if (params.version) {
                    def version = params.version.toLong()
                    if (helpAnnounceInstance.version > version) {
                        helpAnnounceInstance.errors.rejectValue('version', 'default.optimistic.locking.failure',
                                [message(code: 'helpAnnounce.label', default: 'HelpAnnounce')] as Object[],
                                "Another user has updated this HelpAnnounce while you were editing")
                        render view: 'edit', model: [helpAnnounceInstance: helpAnnounceInstance,developers:User.list()]
                        return
                    }
                }

                helpAnnounceInstance.properties = params

                if (!helpAnnounceInstance.save(flush: true)) {
                    render view: 'edit', model: [helpAnnounceInstance: helpAnnounceInstance,developers:User.list()]
                    return
                }

                flash.message = message(code: 'default.updated.message', args: [message(code: 'helpAnnounce.label', default: 'HelpAnnounce'), helpAnnounceInstance.id])
                redirect action: 'show', id: helpAnnounceInstance.id
                break
        }
    }
    @Secured(['ROLE_ADMIN'])
    def delete() {
        def helpAnnounceInstance = HelpAnnounce.get(params.id)
        if (!helpAnnounceInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'helpAnnounce.label', default: 'HelpAnnounce'), params.id])
            redirect action: 'list'
            return
        }

        try {
            helpAnnounceInstance.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'helpAnnounce.label', default: 'HelpAnnounce'), params.id])
            redirect action: 'list'
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'helpAnnounce.label', default: 'HelpAnnounce'), params.id])
            redirect action: 'show', id: params.id
        }
    }
}
