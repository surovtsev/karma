package ru.sggr.karma.announce

/** Анонсированная статья вики */
class WikiAnnounce extends AbstractAnnounce {
    String link
    static constraints = {
        link(blank: false, validator: { val, obj ->
            val.matches(/^http:\/\/.*/)})
    }
    def beforeInsert() {
        super.beforeInsert()
        announceType=AbstractAnnounce.AnnounceType.WIKI
    }
}
