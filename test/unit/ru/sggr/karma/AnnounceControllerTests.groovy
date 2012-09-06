package ru.sggr.karma

import grails.test.mixin.*
import ru.sggr.karma.announce.Announce

@TestFor(AnnounceController)
@Mock(Announce)
class AnnounceControllerTests {

    def populateValidParams(params) {
        assert params != null
        // TODO: Populate valid properties like...
        //params["name"] = 'someValidName'
    }

    void testIndex() {
        controller.index()
        assert "/announce/list" == response.redirectedUrl
    }

    void testList() {

        def model = controller.list()

        assert model.announceInstanceList.size() == 0
        assert model.announceInstanceTotal == 0
    }

    void testCreate() {
        def model = controller.create()

        assert model.announceInstance != null
    }

    void testSave() {
        controller.save()

        assert model.announceInstance != null
        assert view == '/announce/create'

        response.reset()

        populateValidParams(params)
        controller.save()

        assert response.redirectedUrl == '/announce/show/1'
        assert controller.flash.message != null
        assert Announce.count() == 1
    }

    void testShow() {
        controller.show()

        assert flash.message != null
        assert response.redirectedUrl == '/announce/list'

        populateValidParams(params)
        def announce = new Announce(params)

        assert announce.save() != null

        params.id = announce.id

        def model = controller.show()

        assert model.announceInstance == announce
    }

    void testEdit() {
        controller.edit()

        assert flash.message != null
        assert response.redirectedUrl == '/announce/list'

        populateValidParams(params)
        def announce = new Announce(params)

        assert announce.save() != null

        params.id = announce.id

        def model = controller.edit()

        assert model.announceInstance == announce
    }

    void testUpdate() {
        controller.update()

        assert flash.message != null
        assert response.redirectedUrl == '/announce/list'

        response.reset()

        populateValidParams(params)
        def announce = new Announce(params)

        assert announce.save() != null

        // test invalid parameters in update
        params.id = announce.id
        //TODO: add invalid values to params object

        controller.update()

        assert view == "/announce/edit"
        assert model.announceInstance != null

        announce.clearErrors()

        populateValidParams(params)
        controller.update()

        assert response.redirectedUrl == "/announce/show/$announce.id"
        assert flash.message != null

        //test outdated version number
        response.reset()
        announce.clearErrors()

        populateValidParams(params)
        params.id = announce.id
        params.version = -1
        controller.update()

        assert view == "/announce/edit"
        assert model.announceInstance != null
        assert model.announceInstance.errors.getFieldError('version')
        assert flash.message != null
    }

    void testDelete() {
        controller.delete()
        assert flash.message != null
        assert response.redirectedUrl == '/announce/list'

        response.reset()

        populateValidParams(params)
        def announce = new Announce(params)

        assert announce.save() != null
        assert Announce.count() == 1

        params.id = announce.id

        controller.delete()

        assert Announce.count() == 0
        assert Announce.get(announce.id) == null
        assert response.redirectedUrl == '/announce/list'
    }
}
