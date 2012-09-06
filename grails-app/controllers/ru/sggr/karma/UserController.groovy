package ru.sggr.karma

import org.springframework.dao.DataIntegrityViolationException
import org.codehaus.groovy.grails.plugins.springsecurity.SpringSecurityUtils
import grails.plugins.springsecurity.Secured


class UserController {

    transient springSecurityService

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

//    def beforeInterceptor = [action: this.&checkAccess]
    @Secured(['ROLE_ADMIN'])
    def checkAccess() {
        if (SpringSecurityUtils.ifAllGranted('ROLE_ADMIN')) {
            return true
        }
        if (SpringSecurityUtils.ifAllGranted('ROLE_USER')) {
            User user = User.get(params?.id)
            User logged = User.get(springSecurityService.principal.id)
            if (user?.id == logged.id) {
                return true;
            }
        }
        redirect(action: "denied", controller: 'login')
        return false
    }


    @Secured(['ROLE_ADMIN'])
    def list() {
        params.max = Math.min(params.max ? params.int('max') : 20, 100)
        def query = User.where {};
        [userInstanceList:
                query.list(),
                userInstanceTotal: query.count()]
    }
    @Secured(['ROLE_ADMIN'])
    def index() {
        redirect(action: "list", params: params)
    }

    @Secured(['ROLE_ADMIN'])
    def create() {
        [userInstance: new User(params)]
    }

    @Secured(['ROLE_ADMIN'])
    def save() {
        def userInstance = new User(params)
        if (!userInstance.save(flush: true)) {
            render(view: "create", model: [userInstance: userInstance])
            return
        }
        //сходу добавляем роль
        if (!UserRole.create(userInstance, Role.findByAuthority("ROLE_USER"))) {
            render(view: "create", model: [userInstance: userInstance])
            return
        }
        if (params.isAdmin) {
            if (!UserRole.create(userInstance, Role.findByAuthority("ROLE_ADMIN"))) {
                render(view: "create", model: [userInstance: userInstance])
                return
            }
        }
        flash.message = message(code: 'default.created.message', args: [message(code: 'user.label', default: 'User'), userInstance.id])
        redirect(action: "show", id: userInstance.id)
    }

    @Secured(['ROLE_USER'])
    def show() {
        def userInstance = User.get(params.id)
        if (!userInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'user.label', default: 'User'), params.id])
            redirect(action: "list")
            return
        }

        [userInstance: userInstance]
    }

    @Secured(['ROLE_ADMIN'])
    def edit() {
        def userInstance = User.get(params.id)
        if (!userInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'user.label', default: 'User'), params.id])
            redirect(action: "list")
            return
        }

        [userInstance: userInstance]
    }

    @Secured(['ROLE_ADMIN'])
    def update() {
        def userInstance = User.get(params.id)
        if (!userInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'user.label', default: 'User'), params.id])
            redirect(action: "list")
            return
        }

        if (params.version) {
            def version = params.version.toLong()
            if (userInstance.version > version) {
                userInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                        [message(code: 'user.label', default: 'User')] as Object[],
                        "Another user has updated this User while you were editing")
                render(view: "edit", model: [userInstance: userInstance])
                return
            }
        }

        userInstance.properties = params

        if (!userInstance.save(flush: true)) {
            render(view: "edit", model: [userInstance: userInstance])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'user.label', default: 'User'), userInstance.id])
        redirect(action: "show", id: userInstance.id)
    }

    @Secured(['ROLE_ADMIN'])
    def delete() {
        def userInstance = User.get(params.id)
        if (!userInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'user.label', default: 'User'), params.id])
            redirect(action: "list")
            return
        }
        User.withTransaction { status ->
            try {
                UserRole.removeAll(userInstance);
                userInstance.delete(flush: true)
                //userInstance.enabled = false
                //userInstance.save(flush: true)
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'user.label', default: 'User'), params.id])
                redirect(action: "list")
            }
            catch (DataIntegrityViolationException e) {
                status.setRollbackOnly()
//                userInstance.enabled = false
//                userInstance.save(flush: true)
                flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'user.label', default: 'User'), params.id])
                redirect(action: "show", id: params.id)
            }
        }
    }
    @Secured(['ROLE_USER'])
    def profile() {
        def userInstance = User.get(springSecurityService.principal.id)
        if (!userInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'user.label', default: 'User'), params.id])
            redirect("/")
            return
        }

        [userInstance: userInstance]
    }
    @Secured(['ROLE_USER'])
    def updateProfile() {
        def userInstance = User.get(springSecurityService.principal.id)
        if (!userInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'user.label', default: 'User'), params.id])
            redirect('/')
            return
        }

        if (params.version) {
            def version = params.version.toLong()
            if (userInstance.version > version) {
                userInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                        [message(code: 'user.label', default: 'User')] as Object[],
                        "Another user has updated this User while you were editing")
                render(view: "edit", model: [userInstance: userInstance])
                return
            }
        }

        userInstance.properties = params

        if (!userInstance.save(flush: true)) {
            render(view: "edit", model: [userInstance: userInstance])
            return
        }

        flash.message = message(code: 'user.profile.updated.message')
        redirect(action: "profile")
    }
}
