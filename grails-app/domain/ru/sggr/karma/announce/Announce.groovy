package ru.sggr.karma.announce

/** Хорошее дело, оценивает ADMIN_ROLE */

class Announce extends AbstractAnnounce {

    static constraints = {
//        name widget:'textarea'
        description(widget:'textarea', display:true)
    }
    def beforeInsert() {
        super.beforeInsert()
        announceType=AbstractAnnounce.AnnounceType.DEAL
    }
}
