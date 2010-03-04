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
     * @return
     */
    List<Post> listPosts();

    /**
     * Metoda dodaje nowy post.
     * 
     * @param title
     * @param content
     * @return
     */
    Post createPost(String title, String content);

}
