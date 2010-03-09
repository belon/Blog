package pl.project.blog.validator;

import org.springframework.validation.Errors;
import org.springframework.validation.ValidationUtils;
import org.springframework.validation.Validator;
import pl.project.blog.domain.Post;

/**
 *
 * @author Jarosław Bela
 */
public class CreatePostValidator implements Validator {

    public boolean supports(Class<?> clazz) {
        return Post.class.isAssignableFrom(clazz);
    }

    public void validate(Object target, Errors errors) {
        ValidationUtils.rejectIfEmptyOrWhitespace(errors, "title", "field.required");
        ValidationUtils.rejectIfEmptyOrWhitespace(errors, "author", "field.required");
        ValidationUtils.rejectIfEmptyOrWhitespace(errors, "content", "field.required");
    }

}
