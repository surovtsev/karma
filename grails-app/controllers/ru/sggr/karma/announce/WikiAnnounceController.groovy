package ru.sggr.karma.announce

import org.springframework.dao.DataIntegrityViolationException
import grails.plugins.springsecurity.Secured
import ru.sggr.karma.User

@Secured(['ROLE_USER'])
class WikiAnnounceController {

    static allowedMethods = [create: ['GET', 'POST'], edit: ['GET', 'POST'], delete: 'POST']
    @Secured(['ROLE_ADMIN'])
    def index() {
        redirect action: 'list', params: params
    }
    @Secured(['ROLE_ADMIN'])
    def list() {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [wikiAnnounceInstanceList: WikiAnnounce.list(params), wikiAnnounceInstanceTotal: WikiAnnounce.count()]
    }

    def create() {
        switch (request.method) {
            case 'GET':
                [wikiAnnounceInstance: new WikiAnnounce(params)]
                break
            case 'POST':
                def wikiAnnounceInstance = new WikiAnnounce(params)
                if (!wikiAnnounceInstance.save(flush: true)) {
                    render view: 'create', model: [wikiAnnounceInstance: wikiAnnounceInstance]
                    return
                }
                sendMail {
                    to User.all*.email
                    subject "Новая статья wiki от "+wikiAnnounceInstance.author.name
                    body( view:"/shared/mail/newWikiAnnounceMailTemplate",
                          model:[wikiAnnounceInstance:wikiAnnounceInstance])
                }
                flash.message = message(code: 'default.created.message', args: [message(code: 'wikiAnnounce.label', default: 'WikiAnnounce'), wikiAnnounceInstance.id])
                redirect action: 'show', id: wikiAnnounceInstance.id
                break
        }
    }

    def show() {
        def wikiAnnounceInstance = WikiAnnounce.get(params.id)
        if (!wikiAnnounceInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'wikiAnnounce.label', default: 'WikiAnnounce'), params.id])
            redirect action: 'list'
            return
        }

        [wikiAnnounceInstance: wikiAnnounceInstance]
    }

    def edit() {
        switch (request.method) {
            case 'GET':
                def wikiAnnounceInstance = WikiAnnounce.get(params.id)
                if (!wikiAnnounceInstance) {
                    flash.message = message(code: 'default.not.found.message', args: [message(code: 'wikiAnnounce.label', default: 'WikiAnnounce'), params.id])
                    redirect action: 'list'
                    return
                }

                [wikiAnnounceInstance: wikiAnnounceInstance]
                break
            case 'POST':
                def wikiAnnounceInstance = WikiAnnounce.get(params.id)
                if (!wikiAnnounceInstance) {
                    flash.message = message(code: 'default.not.found.message', args: [message(code: 'wikiAnnounce.label', default: 'WikiAnnounce'), params.id])
                    redirect action: 'list'
                    return
                }

                if (params.version) {
                    def version = params.version.toLong()
                    if (wikiAnnounceInstance.version > version) {
                        wikiAnnounceInstance.errors.rejectValue('version', 'default.optimistic.locking.failure',
                                [message(code: 'wikiAnnounce.label', default: 'WikiAnnounce')] as Object[],
                                "Another user has updated this WikiAnnounce while you were editing")
                        render view: 'edit', model: [wikiAnnounceInstance: wikiAnnounceInstance]
                        return
                    }
                }

                wikiAnnounceInstance.properties = params

                if (!wikiAnnounceInstance.save(flush: true)) {
                    render view: 'edit', model: [wikiAnnounceInstance: wikiAnnounceInstance]
                    return
                }

                flash.message = message(code: 'default.updated.message', args: [message(code: 'wikiAnnounce.label', default: 'WikiAnnounce'), wikiAnnounceInstance.id])
                redirect action: 'show', id: wikiAnnounceInstance.id
                break
        }
    }
    @Secured(['ROLE_ADMIN'])
    def delete() {
        def wikiAnnounceInstance = WikiAnnounce.get(params.id)
        if (!wikiAnnounceInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'wikiAnnounce.label', default: 'WikiAnnounce'), params.id])
            redirect action: 'list'
            return
        }

        try {
            wikiAnnounceInstance.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'wikiAnnounce.label', default: 'WikiAnnounce'), params.id])
            redirect action: 'list'
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'wikiAnnounce.label', default: 'WikiAnnounce'), params.id])
            redirect action: 'show', id: params.id
        }
    }
}
