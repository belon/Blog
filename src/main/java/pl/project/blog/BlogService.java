package pl.project.blog;

import java.util.List;
import pl.project.blog.domain.Post;

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
    List<Post> listPosts(Boolean initializeCollections);

    /**
     * Metoda dodaje nowy post.
     * 
     * @param post
     * @return
     */
    Post createPost(Post post);

}
