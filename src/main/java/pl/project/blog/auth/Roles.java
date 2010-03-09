package pl.project.blog.auth;

/**
 *
 * @author Jarosław Bela
 */
public enum Roles {

    ROLE_ADMIN("ROLE_ADMIN"),
    ROLE_USER("ROLE_USER");
    //
    private String roleName;

    private Roles(String roleName) {
        this.roleName = roleName;
    }

    public String getRoleName() {
        return roleName;
    }
}
