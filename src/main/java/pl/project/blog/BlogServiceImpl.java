package pl.project.blog;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.Date;
import java.util.List;
import pl.project.blog.domain.Post;
import org.jcouchdb.db.Database;
import org.jcouchdb.db.Options;
import org.jcouchdb.document.ValueAndDocumentRow;
import org.jcouchdb.document.ViewAndDocumentsResult;
import org.jcouchdb.exception.UpdateConflictException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.InitializingBean;
import org.springframework.beans.factory.annotation.Required;
import org.springframework.security.providers.encoding.ShaPasswordEncoder;
import org.springframework.util.Assert;
import pl.project.blog.auth.Roles;
import pl.project.blog.domain.AppDocument;
import pl.project.blog.domain.Comment;
import pl.project.blog.domain.Tag;
import pl.project.blog.domain.User;

/**
 *
 * @author Jarosław Bela
 */
public class BlogServiceImpl implements BlogService, InitializingBean {

    private static Logger log = LoggerFactory.getLogger(BlogServiceImpl.class);
    private Database database;

    @Required
    public void setDatabase(Database database) {
        Assert.notNull(database, "systemDatabase can't be null");
        this.database = database;
    }

    /**
     * {@inheritDoc}
     */
    public List<Post> listPosts(Boolean initializeCollections) {
        List<Post> posts = new ArrayList<Post>();

        if (initializeCollections) {
            ViewAndDocumentsResult<Object, AppDocument> result = database.queryViewAndDocuments("post/all", Object.class, AppDocument.class, null, null);

            Post lastPost = null;
            for (ValueAndDocumentRow<Object, AppDocument> row : result.getRows()) {
                AppDocument doc = row.getDocument();

                if (doc instanceof Post) {
                    posts.add((Post) doc);
                    lastPost = (Post) doc;
                }

                if (doc instanceof Comment) {
                    lastPost.addComment((Comment) doc);
                }

                if (doc instanceof Tag) {
                    lastPost.addTag((Tag) doc);
                }
            }

            // Sort comments and posts by data
            Collections.sort(posts);
            for (Post post : posts) {
                Collections.sort(post.getComments());
            }
        } else {
            ViewAndDocumentsResult<Object, Post> result = database.queryViewAndDocuments("post/byCreateDate", Object.class, Post.class, Options.option().descending(true), null);

            for (ValueAndDocumentRow<Object, Post> row : result.getRows()) {
                posts.add(row.getDocument());
            }
        }

        return posts;
    }

    /**
     * {@inheritDoc}
     */
    public Post createPost(Post post) {

        try {
            persist(post);
        } catch (IllegalStateException ex) {
            log.error("Document already had a revision set!");
        } catch (UpdateConflictException ex) {
            log.error("There's an update conflict while updating the document!");
        }

        return post;
    }

    public Comment createComment(Comment comment) {

        try {
            persist(comment);
        } catch (IllegalStateException ex) {
            log.error("Document already had a revision set!");
        } catch (UpdateConflictException ex) {
            log.error("There's an update conflict while updating the document!");
        }

        return comment;
    }

    /**
     * {@inheritDoc}
     */
    public User getUser(String userName) {
        ViewAndDocumentsResult<Object, User> result = database.queryViewAndDocuments("user/byName", Object.class, User.class, new Options().key(userName), null);

        if (result.getRows().size() == 0 || result.getRows().size() > 1) {
            return null;
        }

        return result.getRows().get(0).getDocument();
    }

    public void afterPropertiesSet() throws Exception {
        initialize();
    }

    private void initialize() {
        if (listPosts(false).isEmpty()) {

            for (int i = 0; i < 5; i++) {
                Post post = new Post();

                post.setTitle("Title " + i);
                post.setContent("Content " + i);
                post.setCreateDate(new Date(110, 10, 22, 21, 36, 1 + i));

                for (int l = 0; l < 7; l++) {
                    Comment comment = new Comment();
                    comment.setAuthor("Jarek" + l);
                    comment.setContent("Tekst komentarza" + l);
                    comment.setCreated(new Date(110, 10, 22, 21, 36, 1 + l));

                    post.addComment(comment);
                }
                for (int l = 0; l < 5; l++) {
                    Tag tag = new Tag();
                    tag.setName("tag" + l);
                    post.addTag(tag);
                }

                persist(post);
            }
        }

        if (getUser("admin") == null) {
            User user = new User();
            user.setName("admin");
            user.setPasswordHash(new ShaPasswordEncoder(256).encodePassword("admin", null));
            user.setRoles(Arrays.asList(Roles.ROLE_ADMIN.getRoleName(), Roles.ROLE_USER.getRoleName()));
            persist(user);
        }
    }

    /**
     * Metoda do zapisu encji w bazie danych.
     * 
     * @param appDocument
     */
    private void persist(AppDocument appDocument)
            throws IllegalStateException, UpdateConflictException {
        appDocument.beforePersist(database);
        database.createDocument(appDocument);
        appDocument.afterPersist(database);
    }

    /**
     * Metoda do uaktualniania encji w bazie danych.
     * 
     * @param appDocument
     */
    private void update(AppDocument appDocument)
            throws IllegalStateException, UpdateConflictException {
        appDocument.beforeUpdate(database);
        database.updateDocument(appDocument);
        appDocument.afterUpdate(database);
    }
}
