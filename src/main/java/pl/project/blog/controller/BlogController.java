package pl.project.blog.controller;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import pl.project.blog.BlogService;
import pl.project.blog.domain.Post;
import pl.project.blog.util.JSONView;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.support.ReloadableResourceBundleMessageSource;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.validation.Validator;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import pl.project.blog.domain.AppDocument;
import pl.project.blog.domain.Comment;
import pl.project.blog.util.Messages;

/**
 *
 * @author Jarosław Bela
 */
@Controller
public class BlogController {

    private static Logger log = LoggerFactory.getLogger(BlogController.class);
    private BlogService blogService;
    private Validator validator;
    private ReloadableResourceBundleMessageSource messageSource;

    @Autowired
    public void setBlogService(BlogService blogService) {
        this.blogService = blogService;
    }

    @Autowired
    public void setValidator(Validator validator) {
        this.validator = validator;
    }

    @Autowired
    public void setMessageSource(ReloadableResourceBundleMessageSource messageSource) {
        this.messageSource = messageSource;
    }

    /**
     * Strona główna.
     */
    @RequestMapping("/home")
    public String showHome(ModelMap model) {
        model.addAttribute("posts", blogService.listPosts(true));
        return "blog";
    }

    /**
     * Przekierowanie na stronę logowania.
     */
    @RequestMapping("/login")
    public String showLoginForm() {
        return "login";
    }

    /**
     * Akcje dostępne po zalogowaniu z uprawnieniami ROLE_ADMIN
     */
    /**
     * Dodawanie nowego postu.
     */
    @RequestMapping("/admin/newPost")
    public ModelAndView showNewPostForm() {
        return new ModelAndView("admin/newPost", "postObject", new Post()).addObject("tags", blogService.getAvailableTags());
    }

    /**
     * Akcja dodająca nowego posta.
     * 
     * @param request
     * @param ajax
     * @param post
     * @param bindingResult
     * @return
     */
    @RequestMapping(value = "/admin/newPost/create")
    public ModelAndView createNew(
            HttpServletRequest request,
            @RequestParam(value = "ajax", required = false) String ajax,
            @ModelAttribute("postObject") Post post, BindingResult bindingResult) {


        validator.validate(post, bindingResult);
//        ValidationUtils.invokeValidator(new CreatePostValidator(), post, bindingResult);
        if (bindingResult.hasErrors()) {
            if (ajax != null) {
                Map m = new HashMap();
                m.put("ok", false);
                m.put("errors", Messages.getMessagesForErrors(bindingResult, messageSource, request.getLocale()));
                return JSONView.modelAndView(m);
            } else {
                for (FieldError error : bindingResult.getFieldErrors()) {
                    System.out.println("ERROR:  " + error.getField());
                }
                return showNewPostForm();
            }
        }

        post.setCreateDate(new Date());
        blogService.createPost(post);

        if (ajax != null) {
            Map m = new HashMap();
            m.put("ok", true);
            m.put("redirect", "app/home");
            return JSONView.modelAndView(m);
        } else {
            return new ModelAndView("redirect:/app/home");
        }
    }

    @RequestMapping("/admin/delPost")
    public ModelAndView showDeletePostForm(@RequestParam("id") String id) {
        ModelAndView modelAndView = new ModelAndView("admin/delPost");

        AppDocument post = blogService.getPost(id, false);
        modelAndView.addObject("post", post);

        return modelAndView;
    }

    /**
     * Usuń post o danym id oraz wszystkie jego komentarze.
     *
     * @param id        _id of the document to delete
     * @return
     */
    @RequestMapping("/admin/delPost/ok")
    public ModelAndView deletePost(
            @RequestParam(value = "ajax", required = false) String ajax,
            @RequestParam(value = "ok", required = false) String ok,
            @RequestParam("id") String id) {

        if (ok != null) {
            blogService.deletePost(blogService.getPost(id, true));
        }

        if (ajax != null) {
            Map m = new HashMap();
            m.put("ok", true);
            m.put("deleted", id);
            m.put("redirect", "app/home");
            return JSONView.modelAndView(m);
        } else {
            return new ModelAndView("redirect:/app/home");
        }
    }

    /**
     * Strona główna.
     */
    @RequestMapping("/index")
    public String showIndex(ModelMap model) {
        //model.addAttribute("posts", blogService.listPosts(true));
        return "index";
    }

    @RequestMapping("/bloglist")
    public String showBlogList(ModelMap model) {
        model.addAttribute("posts", blogService.listPosts(true));
        return "bloglist";
    }

    /**
     * Pobiera komentarze do odpowiedniego posta
     * @param model
     * @return
     */
    @RequestMapping("/commentlist")
    public ModelAndView showComments(
            @RequestParam(value = "ajax", required = false) String ajax,
            @RequestParam("id") String id) {
        ModelAndView modelAndView = new ModelAndView("commentlist");

        List<Comment> comments = blogService.getCommentsForPost(id);

        if (ajax != null) {
            Map m = new HashMap();
            m.put("ok", true);
            m.put("comments", comments);
            return JSONView.modelAndView(m);
        } else {
            return modelAndView.addObject("comments", comments);
        }
    }
}
