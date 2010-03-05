package pl.project.blog.domain;

/**
 *
 * @author Jarosław Bela
 */
public class Tag extends AppDocument implements Comparable<Tag> {

    String post_id;
    //
    String name;

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getPost_id() {
        return post_id;
    }

    public void setPost_id(String post_id) {
        this.post_id = post_id;
    }

    public int compareTo(Tag o) {
        if (getName() != null && o.getName() != null) {
            return getName().compareTo(o.getName());
        }
        return 0;
    }
}
