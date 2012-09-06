

import org.codehaus.groovy.grails.commons.GrailsClass

import java.lang.annotation.Annotation


class SecurityHelper {

    private static final List<String> ANNOTATION_CLASS_NAMES = Arrays.asList(
            grails.plugins.springsecurity.Secured.class.getName(),
            org.springframework.security.access.annotation.Secured.class.getName());

    static List requiredRoles(GrailsClass controllerClass) {

        def secured = findAnnotation(controllerClass.getClazz().getAnnotations())
        def roles = []

        secured.each {
            roles.addAll(getValue(it))
        }

        return roles.asList()
    }

    static String requiredRolesString(GrailsClass controllerClass){
        return requiredRoles(controllerClass).join(",");

    }



    private static Annotation findAnnotation(Annotation[] annotations) {
        for (Annotation annotation : annotations) {
            if (ANNOTATION_CLASS_NAMES.contains(annotation.annotationType().getName())) {
                return annotation;
            }
        }
        return null;
    }

    private static String[] getValue(Annotation annotation) {
        if (annotation instanceof grails.plugins.springsecurity.Secured) {
            return ((grails.plugins.springsecurity.Secured)annotation).value();
        }
        return ((org.springframework.security.access.annotation.Secured)annotation).value();
    }


}
