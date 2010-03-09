package pl.project.blog;

import java.util.List;
import pl.project.blog.domain.Post;
import pl.project.blog.domain.User;

/**
 *
 * @author Jarosław Bela
 */
public interface BlogService {

    /**
     * Metoda zwraca listę wszystkich postów
     *
     * @param initializeCollections określa czy kolekcje mają być również
     *          dołączone
     * @return
     */
    public List<Post> listPosts(Boolean initializeCollections);

    /**
     * Metoda dodaje nowy post.
     * 
     * @param post
     * @return
     */
    public Post createPost(Post post);

    /**
     * Metoda pobiera użytkownika o danej nazwie.
     * Jeśli użytkownika nie ma w bazie to zwraca null.
     * 
     * @param userName
     * @return
     */
    public User getUser(String userName);

}
