package pl.project.blog.domain;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import org.jcouchdb.db.Database;
import org.springmodules.validation.bean.conf.loader.annotation.handler.NotBlank;
import org.svenson.JSONProperty;
import org.svenson.converter.JSONConverter;
import pl.project.blog.converter.DateConverter;

/**
 *
 * @author Jarosław Bela
 */
public class Post extends AppDocument implements Comparable<Post> {

    @NotBlank(errorCode = "field.title.required")
    String title;
    @NotBlank(errorCode = "field.content.required")
    String content;
    Date createDate;
    Date modifyDate;
    List<Comment> comments = new ArrayList<Comment>();
    List<Tag> tags = new ArrayList<Tag>();
    //
    List<String> tagIds = new ArrayList<String>();

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

    /**
     * Metoda zwraca true jeśli post zawiera tag
     * o podanym id.
     * 
     * @param tagId
     * @return
     */
    public Boolean containTag(String tagId) {
        for (Tag tag : tags) {
            if (tag.getId().equals(tagId)) {
                return true;
            }
        }
        return false;
    }

    @Override
    public void afterPersist(Database database) {
        // Zapisz w bazie wszystkie komentarze
        for (Comment comment : comments) {
            comment.setPost_id(this.getId());
            database.createDocument(comment);
        }
        // Zapisz w bazie wszystkie tagi
        for (String tagId : tagIds) {
            // Zapisz relację pomiędzy tagiem a postem
            PostTag postTag = new PostTag();
            postTag.setPost_id(this.getId());
            postTag.setTag_id(tagId);
            database.createDocument(postTag);

            // Zwiększ licznik częstości występowania w tagu
            Tag tag = database.getDocument(Tag.class, tagId);
            tag.setCount(tag.getCount() + 1);
            database.updateDocument(tag);
        }
    }

    @Override
    public void afterUpdate(Database database) {
        // Zapisz w bazie wszystkie tagi
        for (String tagId : tagIds) {
            if (!containTag(tagId)) {
                // Zapisz relację pomiędzy tagiem a postem
                PostTag postTag = new PostTag();
                postTag.setPost_id(this.getId());
                postTag.setTag_id(tagId);
                database.createDocument(postTag);

                // Zwiększ licznik częstości występowania w tagu
                Tag tag = database.getDocument(Tag.class, tagId);
                tag.setCount(tag.getCount() + 1);
                database.updateDocument(tag);
                addTag(tag);
            }
        }
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    @JSONProperty(ignore = true)
    public List<Tag> getTags() {
        return tags;
    }

    @JSONProperty(ignore = true)
    public List<Comment> getComments() {
        return comments;
    }

    public void setComments(List<Comment> comments) {
        this.comments = comments;
    }

    public void setTags(List<Tag> tags) {
        this.tags = tags;
    }

    public Date getCreateDate() {
        return createDate;
    }

    @JSONConverter(type = DateConverter.class)
    public void setCreateDate(Date createDate) {
        this.createDate = createDate;
    }

    public Date getModifyDate() {
        return modifyDate;
    }

    @JSONConverter(type = DateConverter.class)
    public void setModifyDate(Date modifyDate) {
        this.modifyDate = modifyDate;
    }

    @JSONProperty(ignore = true)
    public List<String> getTagIds() {
        if (tagIds.isEmpty() && !tags.isEmpty()) {
            for (Tag tag : tags) {
                tagIds.add(tag.getId());
            }
        }
        return tagIds;
    }

    public void setTagIds(List<String> tagIds) {
        this.tagIds = tagIds != null ? tagIds : new ArrayList<String>();
    }

    public int compareTo(Post o) {
        if (getCreateDate() != null && o.getCreateDate() != null) {
            return o.getCreateDate().compareTo(createDate);
        }
        return 0;
    }
}
