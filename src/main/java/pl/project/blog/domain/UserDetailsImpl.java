package pl.project.blog.domain;

import java.util.List;

import org.springframework.security.GrantedAuthority;
import org.springframework.security.GrantedAuthorityImpl;
import org.springframework.security.userdetails.UserDetails;

/**
 * Implementacja klasy UserDetails zwracana podczas autoryzacji.
 * 
 * @author Jarosław Bela
 */
public class UserDetailsImpl implements UserDetails {

    private static final long serialVersionUID = -1293499923487390796L;
    private String passwordHash;
    private List<String> roles;
    private boolean enabled = true;
    private boolean credentialsNonExpired = true;
    private boolean accountNonLocked = true;
    private boolean accountNonExpired = true;
    private String userId;
    private String userName;

    public UserDetailsImpl(User u) {
        passwordHash = u.getPasswordHash();
        userId = u.getId();
        roles = u.getRoles();
        enabled = u.isEnabled();
        accountNonExpired = u.isAccountNonExpired();
        accountNonLocked = u.isAccountNonLocked();
        credentialsNonExpired = u.isCredentialsNonExpired();
    }

    public GrantedAuthority[] getAuthorities() {
        if (roles == null) {
            return new GrantedAuthority[]{};
        }

        GrantedAuthority[] auths = new GrantedAuthority[roles.size()];
        int idx = 0;
        for (String role : roles) {
            auths[idx++] = new GrantedAuthorityImpl(role);
        }

        return auths;
    }

    public String getUsername() {
        return userName;
    }

    public String getUserId() {
        return userId;
    }

    public String getPassword() {
        return passwordHash;
    }

    public boolean isAccountNonExpired() {
        return accountNonExpired;
    }

    public boolean isAccountNonLocked() {
        return accountNonLocked;
    }

    public boolean isCredentialsNonExpired() {
        return credentialsNonExpired;
    }

    public boolean isEnabled() {
        return enabled;
    }

    public List<String> getRoles() {
        return roles;
    }
}
