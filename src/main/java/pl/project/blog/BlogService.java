package pl.project.blog;

import java.util.List;
import pl.project.blog.domain.Comment;
import pl.project.blog.domain.Post;
import pl.project.blog.domain.Tag;
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
     * Metoda usuwa dokument.
     *
     * @param post
     */

    /*
     *
     * Metoda aktualizująca post
     *
     */
    public Post updatePost(Post post);

    public void deletePost(Post post);

    /**
     * Metoda zwraca dokument o podanym id.
     * 
     * @param id
     * @return
     */
    public Post getPost(String id, Boolean initializeCollections);

    /**
     * Metoda zwraca listę komentarzy dla postu.
     * 
     * @param id
     * @return
     */
    public List<Comment> getCommentsForPost(String id);

    /**
     * Metoda pobiera użytkownika o danej nazwie.
     * Jeśli użytkownika nie ma w bazie to zwraca null.
     * 
     * @param userName
     * @return
     */
    public User getUser(String userName);

    public Comment createComment(Comment comment);
    /**
     * Metoda zwraca dostępne tagi.
     * 
     * @return
     */
    public List<Tag> getAvailableTags(Boolean forceReload);
}
