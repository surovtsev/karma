package ru.sggr.karma.announce

import ru.sggr.karma.User
import ru.sggr.karma.KarmaHistory

abstract class AbstractAnnounce {

    transient springSecurityService

    User author
    String name
    Date dateCreated
    Date lastUpdated
    enum AnnounceType {
        DEAL {
            String toString() {
                return "Идея, нововведение";
            }
        },
        WIKI {
            String toString() {
                return "Статья wiki";
            }
        },
        HELP {
            String toString() {
                return "Помощь разработчику";
            }
        },
        CHANGEKARMA {
            String toString() {
                return "Изменение кармы";
            }
        }
        static AnnounceType
    }
    AnnounceType announceType
    //Карма статьи
    Double karma=0
    static constraints = {
        name(blank: false)
        karma(display:false)
        author(display:false,nullable: true)
        announceType(display:false,nullable: true)
        dateCreated nullable: true
        lastUpdated nullable: true
    }

    def beforeUpdate() {
        lastUpdated = new Date()
    }

    def beforeInsert() {
        dateCreated = new Date()
        if (!author) author = (User) springSecurityService.getCurrentUser()
    }

    String toString(){
        return name;
    }
    /** Голосовал ли пользователь за этот анонс уже*/
    def getIsVoted(){
        return KarmaHistory.findByAnnounceAndAuthor(this,(User) springSecurityService.getCurrentUser())
    }
}
