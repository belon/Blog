package pl.project.blog.auth;

import org.jcouchdb.db.Database;
import org.jcouchdb.db.Options;
import org.jcouchdb.document.ViewAndDocumentsResult;
import org.springframework.beans.factory.annotation.Required;
import org.springframework.dao.DataAccessException;
import org.springframework.security.userdetails.UserDetails;
import org.springframework.security.userdetails.UserDetailsService;
import org.springframework.security.userdetails.UsernameNotFoundException;
import pl.project.blog.domain.User;
import pl.project.blog.domain.UserDetailsImpl;

/**
 * Implementacja serwisu Spring Security.
 * 
 * @author Jarosław Bela
 *
 */
public class UserDetailsServiceImpl implements UserDetailsService {

    private Database database;

    @Required
    public void setDatabase(Database database) {
        this.database = database;
    }

    /**
     * Metoda wczytuje użytkownika po jego nazwie.
     * 
     * @param userName Nazwa użytkownika
     * @return
     * @throws UsernameNotFoundException
     * @throws DataAccessException
     */
    public UserDetails loadUserByUsername(String userName)
            throws UsernameNotFoundException, DataAccessException {
        
        ViewAndDocumentsResult<Object, User> result = database.queryViewAndDocuments("user/byName", Object.class, User.class, new Options().key(userName), null);
        if (result.getRows().size() == 0) {
            throw new UsernameNotFoundException("User '" + userName + "' not found.");
        }
        if (result.getRows().size() > 1) {
            throw new UsernameNotFoundException("More than one user '" + userName + "' found.");
        }

        return new UserDetailsImpl(result.getRows().get(0).getDocument());
    }
}
