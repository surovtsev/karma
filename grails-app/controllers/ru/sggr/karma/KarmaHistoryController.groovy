package ru.sggr.karma

import org.springframework.dao.DataIntegrityViolationException
import ru.sggr.karma.announce.Announce
import ru.sggr.karma.announce.AbstractAnnounce
import grails.plugins.springsecurity.Secured
import ru.sggr.karma.announce.ChangeKarmaAnnounce

@Secured(['ROLE_USER'])
class KarmaHistoryController {
    static scaffold = true
    transient springSecurityService
    static allowedMethods = [create: ['GET', 'POST'], edit: ['GET', 'POST'], delete: 'POST']

    @Secured(['ROLE_ADMIN'])
    def index() {
        redirect action: 'list', params: params
    }

    @Secured(['ROLE_ADMIN'])
    def list() {
        params.max = Math.min(params.max ? params.int('max') : 20, 100)
        [karmaHistoryInstanceList: KarmaHistory.list(params), karmaHistoryInstanceTotal: KarmaHistory.count()]
    }
    @Secured(['ROLE_ADMIN'])
    def create() {
        switch (request.method) {
            case 'GET':
                [karmaHistoryInstance: new KarmaHistory(params),announceInstance:new ChangeKarmaAnnounce(params)]
                break
            case 'POST':
                def changeKarmaAnnounceInstance = new ChangeKarmaAnnounce(params)
                changeKarmaAnnounceInstance.save(flush: true)

                def karmaHistoryInstance = new KarmaHistory(params)
                karmaHistoryInstance.announce=changeKarmaAnnounceInstance
                if (!karmaHistoryInstance.save(flush: true)) {
                    render view: 'create', model: [karmaHistoryInstance: karmaHistoryInstance,announceInstance:new ChangeKarmaAnnounce(params)]
                    return
                }
                sendMail {
                    to karmaHistoryInstance.user.email
                    subject karmaHistoryInstance.karmaChange+" к карме"
                    body( view:"/shared/mail/newKarmaHistoryMailTemplate",
                            model:[karmaHistoryInstance:karmaHistoryInstance])
                }
                flash.message = message(code: 'default.created.message', args: [message(code: 'karmaHistory.label', default: 'KarmaHistory'), karmaHistoryInstance.id])
                redirect action: 'show', id: karmaHistoryInstance.id
                break
        }
    }
    @Secured(['ROLE_ADMIN'])
    def show() {
        def karmaHistoryInstance = KarmaHistory.get(params.id)
        if (!karmaHistoryInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'karmaHistory.label', default: 'KarmaHistory'), params.id])
            redirect action: 'list'
            return
        }

        [karmaHistoryInstance: karmaHistoryInstance]
    }
    @Secured(['ROLE_ADMIN'])
    def edit() {
        switch (request.method) {
            case 'GET':
                def karmaHistoryInstance = KarmaHistory.get(params.id)
                if (!karmaHistoryInstance) {
                    flash.message = message(code: 'default.not.found.message', args: [message(code: 'karmaHistory.label', default: 'KarmaHistory'), params.id])
                    redirect action: 'list'
                    return
                }

                [karmaHistoryInstance: karmaHistoryInstance]
                break
            case 'POST':
                def karmaHistoryInstance = KarmaHistory.get(params.id)
                if (!karmaHistoryInstance) {
                    flash.message = message(code: 'default.not.found.message', args: [message(code: 'karmaHistory.label', default: 'KarmaHistory'), params.id])
                    redirect action: 'list'
                    return
                }

                if (params.version) {
                    def version = params.version.toLong()
                    if (karmaHistoryInstance.version > version) {
                        karmaHistoryInstance.errors.rejectValue('version', 'default.optimistic.locking.failure',
                                [message(code: 'karmaHistory.label', default: 'KarmaHistory')] as Object[],
                                "Another user has updated this KarmaHistory while you were editing")
                        render view: 'edit', model: [karmaHistoryInstance: karmaHistoryInstance]
                        return
                    }
                }

                karmaHistoryInstance.properties = params

                if (!karmaHistoryInstance.save(flush: true)) {
                    render view: 'edit', model: [karmaHistoryInstance: karmaHistoryInstance]
                    return
                }

                flash.message = message(code: 'default.updated.message', args: [message(code: 'karmaHistory.label', default: 'KarmaHistory'), karmaHistoryInstance.id])
                redirect action: 'show', id: karmaHistoryInstance.id
                break
        }
    }
    @Secured(['ROLE_ADMIN'])
    def delete() {
        def karmaHistoryInstance = KarmaHistory.get(params.id)
        if (!karmaHistoryInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'karmaHistory.label', default: 'KarmaHistory'), params.id])
            redirect action: 'list'
            return
        }

        try {
            // возвращаем карму как было
            karmaHistoryInstance.user.karma=karmaHistoryInstance.user.karma-karmaHistoryInstance.karmaChange;
            if (karmaHistoryInstance.announce)
                karmaHistoryInstance.announce.karma=karmaHistoryInstance.announce.karma-karmaHistoryInstance.karmaChange;

            karmaHistoryInstance.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'karmaHistory.label', default: 'KarmaHistory'), params.id])
            redirect action: 'list'
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'karmaHistory.label', default: 'KarmaHistory'), params.id])
            redirect action: 'show', id: params.id
        }

    }

    def thanks(){
        def announce=AbstractAnnounce.get(params.id);
        def author = (User) springSecurityService.getCurrentUser()
        if (!KarmaHistory.findByAnnounceAndAuthor(announce,author)) {
        def karmaHistory= new KarmaHistory(karmaChange: 1, announce: announce, author: author)
            karmaHistory.save(flush: true)
            flash.message = message(code: 'default.karmathanks.message')
        }
        else
            flash.message = message(code: 'default.youalredysaidsanks.message')

        redirect controller: "home", action: "index"

    }
}
