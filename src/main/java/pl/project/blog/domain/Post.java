package pl.project.blog.domain;

/**
 *
 * @author Jarosław Bela
 */
public class Post extends AppDocument {

    String title, content;

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
}
