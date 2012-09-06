import grails.plugins.springsecurity.Secured
import ru.sggr.karma.User
import ru.sggr.karma.announce.AbstractAnnounce
import ru.sggr.karma.announce.WikiAnnounce
import ru.sggr.karma.announce.HelpAnnounce
import ru.sggr.karma.KarmaHistory
import ru.sggr.karma.announce.Announce

class HomeController {
    transient springSecurityService

    @Secured(['ROLE_USER'])
    def index() {
        def currentUser=(User) springSecurityService.getCurrentUser()
        def karmaQuery = User.createCriteria();
        def karmaList=karmaQuery.list{
            and{
                order('karma','desc')
                order('name','asc')
            }
        }
        //todo: допиасть чтобы выводились статьи, с которыми не ознакомился
        def wikiAnnounceQuery = WikiAnnounce.where {};

        def helpAnnounceQuery = HelpAnnounce.where {helpedDevelopers {id==currentUser.id}};

        def announceQuery = Announce.where {};
        def karmaHistoryList = KarmaHistory.findAllByUser(currentUser)

        [
                karmaList:karmaList,
                karmaListTotal: karmaQuery.count(),
                wikiAnnouncesList: wikiAnnounceQuery.list(sort: "dateCreated", order:"desc", max: 20),
                wikiAnnouncesListTotal:wikiAnnounceQuery.count(),
                helpAnnouncesList: helpAnnounceQuery.list(sort: "dateCreated", order:"desc", max: 20),
                helpAnnouncesListTotal:helpAnnounceQuery.count(),
                announcesList:announceQuery.list(sort: "dateCreated", order:"desc", max: 20),
                currentUser:currentUser,
                karmaHistoryList:karmaHistoryList
        ]
    }
}
