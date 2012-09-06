package ru.sggr.karma.announce

import ru.sggr.karma.User

class HelpAnnounce extends AbstractAnnounce {
    static hasMany = [helpedDevelopers: User]
    static constraints = {
    }
    def beforeInsert() {
        super.beforeInsert()
        announceType=AbstractAnnounce.AnnounceType.HELP
    }
}
