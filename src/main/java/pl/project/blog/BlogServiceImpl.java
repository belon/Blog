package pl.project.blog;

import java.util.ArrayList;
import java.util.List;
import pl.project.blog.domain.Post;
import org.jcouchdb.db.Database;
import org.jcouchdb.document.ValueAndDocumentRow;
import org.jcouchdb.document.ViewAndDocumentsResult;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.InitializingBean;
import org.springframework.beans.factory.annotation.Required;
import org.springframework.util.Assert;

/**
 *
 * @author Jarosław Bela
 */
public class BlogServiceImpl implements BlogService, InitializingBean {

    private static Logger log = LoggerFactory.getLogger(BlogServiceImpl.class);
    // Baza danych
    private Database systemDatabase;

    /**
     * Provices the system database
     * 
     * @param systemDatabase
     */
    @Required
    public void setSystemDatabase(Database systemDatabase) {
        Assert.notNull(systemDatabase, "systemDatabase can't be null");

        this.systemDatabase = systemDatabase;
    }

    public List<Post> listPosts() {
        ViewAndDocumentsResult<Object, Post> result = systemDatabase.queryViewAndDocuments("post/byTitle", Object.class, Post.class, null, null);

        List<Post> posts = new ArrayList<Post>();
        for (ValueAndDocumentRow<Object, Post> row : result.getRows()) {
            posts.add(row.getDocument());
        }
        return posts;
    }

    public Post createPost(String title, String content) {  
        Post post = new Post();

        post.setTitle(title);
        post.setContent(content);

        systemDatabase.createDocument(post);

        return post;
    }

    private void initialize() {
        if (listPosts().isEmpty()) {
            createPost("Temat postu", "Treść przykładowego postu.");
        }
    }

    public void afterPropertiesSet() throws Exception {
        initialize();
    }
}
