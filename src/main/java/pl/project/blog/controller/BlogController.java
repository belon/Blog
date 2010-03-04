package pl.project.blog.controller;

import java.util.HashMap;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import pl.project.blog.BlogService;
import pl.project.blog.domain.Post;
import pl.project.blog.util.JSONView;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

/**
 *
 * @author Jarosław Bela
 */
@Controller
public class BlogController {

    private static Logger log = LoggerFactory.getLogger(BlogController.class);

    private BlogService blogService;

    @Autowired
    public void setBlogService(BlogService blogService) {
        this.blogService = blogService;
    }

    /**
     * Shows the hood view with default hood.
     *
     * @param model     model map
     * @return
     */
    @RequestMapping("/home")
    public String showHome(ModelMap model) {
        model.addAttribute("posts", blogService.listPosts());

        return "blog";
    }

    @RequestMapping("/new")
    public ModelAndView showNewObjectForm() {
        return new ModelAndView("newObject");
    }

    @ModelAttribute("newObject")
    public Post initCommand() {
        return new Post();
    }

    @RequestMapping(value = "/new/create")
    public ModelAndView createNew(
            HttpServletRequest request,
            @RequestParam(value = "ajax", required = false) String ajax,
            @ModelAttribute("newObject") Post postCommand, BindingResult bindingResult) {


//        ValidationUtils.invokeValidator(newObjectCommandValidator, postCommand, bindingResult);
//        if (bindingResult.hasErrors()) {
//            if (ajax != null) {
//                Map m = new HashMap();
//                m.put("ok", false);
//                m.put("errors", bindingResult.getAllErrors());
//                return JSONView.modelAndView(m);
//            } else {
//                return showNewObjectForm();
//            }
//        }

        log.debug("Request value is {}, creating {}", request.getParameter("name"), postCommand);

        blogService.createPost(postCommand.getTitle(), postCommand.getContent());

        if (ajax != null) {
            Map m = new HashMap();
            m.put("ok", true);
            return JSONView.modelAndView(m);
        } else {
            return new ModelAndView("redirect:/app/home");
        }
    }
}
