package ru.sggr.karma.announce

import org.springframework.dao.DataIntegrityViolationException
import grails.plugins.springsecurity.Secured
import ru.sggr.karma.UserRole
import ru.sggr.karma.Role

@Secured(['ROLE_USER'])
class AnnounceController {

    static allowedMethods = [create: ['GET', 'POST'], edit: ['GET', 'POST'], delete: 'POST']
    @Secured(['ROLE_ADMIN'])
    def index() {
        redirect action: 'list', params: params
    }
    @Secured(['ROLE_ADMIN'])
    def list() {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [announceInstanceList: Announce.list(params), announceInstanceTotal: Announce.count()]
    }

    def create() {
        switch (request.method) {
            case 'GET':
                [announceInstance: new Announce(params)]
                break
            case 'POST':
                def announceInstance = new Announce(params)
                if (!announceInstance.save(flush: true)) {
                    render view: 'create', model: [announceInstance: announceInstance]
                    return
                }
                def adminsEmails=UserRole.findByRole(Role.findByAuthority("ROLE_ADMIN"))*.user*.email;
                sendMail {
                    to adminsEmails
                    subject "Новое предложение, идея от разработчика "+announceInstance.author.name
                    body( view:"/shared/mail/newAnnounceMailTemplate",
                            model:[announceInstance:announceInstance])
                }
                flash.message = message(code: 'default.created.message', args: [message(code: 'announce.label', default: 'Announce'), announceInstance.id])
                redirect action: 'show', id: announceInstance.id
                break
        }
    }

    def show() {
        def announceInstance = Announce.get(params.id)
        if (!announceInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'announce.label', default: 'Announce'), params.id])
            redirect action: 'list'
            return
        }

        [announceInstance: announceInstance]
    }

    def edit() {
        switch (request.method) {
            case 'GET':
                def announceInstance = Announce.get(params.id)
                if (!announceInstance) {
                    flash.message = message(code: 'default.not.found.message', args: [message(code: 'announce.label', default: 'Announce'), params.id])
                    redirect action: 'list'
                    return
                }

                [announceInstance: announceInstance]
                break
            case 'POST':
                def announceInstance = Announce.get(params.id)
                if (!announceInstance) {
                    flash.message = message(code: 'default.not.found.message', args: [message(code: 'announce.label', default: 'Announce'), params.id])
                    redirect action: 'list'
                    return
                }

                if (params.version) {
                    def version = params.version.toLong()
                    if (announceInstance.version > version) {
                        announceInstance.errors.rejectValue('version', 'default.optimistic.locking.failure',
                                [message(code: 'announce.label', default: 'Announce')] as Object[],
                                "Another user has updated this Announce while you were editing")
                        render view: 'edit', model: [announceInstance: announceInstance]
                        return
                    }
                }

                announceInstance.properties = params

                if (!announceInstance.save(flush: true)) {
                    render view: 'edit', model: [announceInstance: announceInstance]
                    return
                }

                flash.message = message(code: 'default.updated.message', args: [message(code: 'announce.label', default: 'Announce'), announceInstance.id])
                redirect action: 'show', id: announceInstance.id
                break
        }
    }
    @Secured(['ROLE_ADMIN'])
    def delete() {
        def announceInstance = Announce.get(params.id)
        if (!announceInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'announce.label', default: 'Announce'), params.id])
            redirect action: 'list'
            return
        }

        try {
            announceInstance.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'announce.label', default: 'Announce'), params.id])
            redirect action: 'list'
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'announce.label', default: 'Announce'), params.id])
            redirect action: 'show', id: params.id
        }
    }
}
