package pl.project.blog.domain;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import org.jcouchdb.db.Database;
import org.svenson.JSONProperty;
import org.svenson.converter.JSONConverter;
import pl.project.blog.converter.DateConverter;

/**
 *
 * @author Jarosław Bela
 */
public class Post extends AppDocument implements Comparable<Post> {

    String title;
    String content;
    String author;
    Date createDate;
    Date modifyDate;
    List<Comment> comments = new ArrayList<Comment>();
    List<Tag> tags = new ArrayList<Tag>();

    /**
     * Metoda dodaje komentarz do postu.
     * 
     * @param comment
     */
    public void addComment(Comment comment) {
        if (comment != null) {
            comments.add(comment);
        }
    }

    /**
     * Metoda dodaje tag do postu.
     * 
     * @param tag
     */
    public void addTag(Tag tag) {
        if (tag != null) {
            tags.add(tag);
        }
    }


    @Override
    public void afterPersist(Database database) {
        // Zapisz w bazie wszystkie komentarze
        for (Comment comment : comments) {
            comment.setPost_id(this.getId());
            database.createDocument(comment);
        }
        // Zapisz w bazie wszystkie tagi
        for (Tag tag : tags) {
            tag.setPost_id(this.getId());
            database.createDocument(tag);
        }
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        if (content != null) {
            content = content.replaceAll("\r\n", "<br />").replaceAll("\n", "<br />");
        }
        this.content = content;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getAuthor() {
        return author;
    }

    public void setAuthor(String author) {
        this.author = author;
    }

    @JSONProperty(ignore=true)
    public List<Tag> getTags() {
        return tags;
    }

    @JSONProperty(ignore=true)
    public List<Comment> getComments() {
        return comments;
    }

    public Date getCreateDate() {
        return createDate;
    }

    @JSONConverter(type=DateConverter.class)
    public void setCreateDate(Date createDate) {
        this.createDate = createDate;
    }

    public Date getModifyDate() {
        return modifyDate;
    }

    public void setModifyDate(Date modifyDate) {
        this.modifyDate = modifyDate;
    }

    public int compareTo(Post o) {
        if (getCreateDate() != null && o.getCreateDate() != null) {
            return o.getCreateDate().compareTo(createDate);
        }
        return 0;
    }
}
