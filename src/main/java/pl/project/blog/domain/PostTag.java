package pl.project.blog.domain;

/**
 *
 * @author Jarosław Bela
 */
public class PostTag extends AppDocument {
    String post_id;
    String tag_id;

    public String getPost_id() {
        return post_id;
    }

    public void setPost_id(String post_id) {
        this.post_id = post_id;
    }

    public String getTag_id() {
        return tag_id;
    }

    public void setTag_id(String tag_id) {
        this.tag_id = tag_id;
    }
}
