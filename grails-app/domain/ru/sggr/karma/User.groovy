package ru.sggr.karma

class User {

    transient springSecurityService

    String username
    String password
    boolean enabled=true
    boolean accountExpired=false
    boolean accountLocked=false
    boolean passwordExpired=false
    String email
    String name
    Date dateCreated
    Date lastUpdated
    Double karma=0
    static constraints = {
        name blank: false
        username blank: false, unique: true
        password blank: false,password:true
        email blank: false, email: true, unique: true
        dateCreated nullable: true
        lastUpdated nullable: true
        enabled display:false
        accountExpired display:false
        accountLocked display:false
        passwordExpired display:false


    }

    static mapping = {
        table '`user`'
        password column: '`password`'
    }


    Set<Role> getAuthorities() {
        UserRole.findAllByUser(this).collect { it.role } as Set
    }

    def beforeInsert() {
        encodePassword()
        dateCreated = new Date()
    }

    def beforeUpdate() {
        if (isDirty('password')) {
            encodePassword()
        }
        lastUpdated = new Date()
    }

    protected void encodePassword() {
        password = springSecurityService.encodePassword(password)
    }

    String toString(){
        return name;
    }
}
