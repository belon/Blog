package pl.project.blog.domain;

import java.util.ArrayList;
import java.util.List;
import org.svenson.JSONProperty;

/**
 *
 * @author Jarosław Bela
 */
public class Tag extends AppDocument implements Comparable<Tag> {

    List<Post> posts = new ArrayList<Post>();
    //
    String name;

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    @JSONProperty(ignore=true)
    public List<Post> getPosts() {
        return posts;
    }

    public void setPosts(List<Post> posts) {
        this.posts = posts;
    }

    public int compareTo(Tag o) {
        if (getName() != null && o.getName() != null) {
            return getName().compareTo(o.getName());
        }
        return 0;
    }

    @Override
    public String toString() {
        return this.name;
    }
}
