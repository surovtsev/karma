package ru.sggr.karma.announce

/* Изменение кармы */
class ChangeKarmaAnnounce extends AbstractAnnounce {
    static constraints = {
        name widget:'textarea'
    }
    def beforeInsert() {
        super.beforeInsert()
        announceType=AbstractAnnounce.AnnounceType.CHANGEKARMA
    }
}
