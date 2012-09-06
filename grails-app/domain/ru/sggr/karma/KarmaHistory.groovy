package ru.sggr.karma

import ru.sggr.karma.announce.AbstractAnnounce

/**
 * Содержит историю изменения кармы
 * */
class KarmaHistory {
    transient springSecurityService
    //автор изменения кармы
    User author
    //кому меняем карму
    User user
    Date dateCreated
    Date lastUpdated
    //степень изменения кармы
    Double karmaChange=0
    AbstractAnnounce announce

    static constraints = {
        dateCreated nullable: true
        lastUpdated nullable: true
        announce (nullable: true, unique: ['user'])
        author nullable: true
        user nullable: true
    }

    def beforeInsert() {
        dateCreated = new Date()
        if (!author) author = (User) springSecurityService.getCurrentUser()
        if (!user) user = announce.author
    }

    def beforeUpdate() {
        lastUpdated = new Date()
    }

    def afterInsert(){
        user.karma=user.karma+karmaChange
        if (announce) announce.karma=announce.karma+karmaChange
    }
}
