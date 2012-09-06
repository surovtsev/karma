package karma

import ru.sggr.karma.KarmaHistory
import ru.sggr.karma.announce.AbstractAnnounce
import ru.sggr.karma.User

/**
 *
 * @author: Суровцев Александр (asurovtsev@sg-gr.ru)
 * Date: 23.08.12
 * Time: 10:08
 */

class karmaTagLib {
    transient springSecurityService
    static namespace = "karma"
    /** Рисует кнопку Спасибо, для announce*/
    def thanksButton = { attrs ->
        if (attrs.announceId) {
            User currentUser = User.get(springSecurityService.principal.id)
            def announce= AbstractAnnounce.get(attrs.announceId)
            if (announce) {
                out << render(template: "/shared/karmaButtonTemplate", model: [announceId: attrs.announceId,alreadySaidThanks:announce.getIsVoted()||announce.author==currentUser])
            }
        }
    }
}
