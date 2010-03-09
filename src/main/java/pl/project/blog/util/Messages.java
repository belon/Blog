package pl.project.blog.util;

import java.util.HashMap;
import java.util.Locale;
import java.util.Map;
import org.springframework.context.support.ReloadableResourceBundleMessageSource;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.validation.ObjectError;

/**
 *
 * @author Jarosław Bela
 */
public class Messages {

    public static Map<String, String> getMessagesForErrors(BindingResult bindingResult, ReloadableResourceBundleMessageSource messageSource, Locale locale) {
        Map<String, String> errorMap = new HashMap<String, String>();

        // Dodaj wszytkie błędy walidacji przypisane do pól
        for (FieldError error : bindingResult.getFieldErrors()) {
            errorMap.put(error.getField(), messageSource.getMessage(error.getCode(), error.getArguments(), locale));
        }

        // Dodaj wszytkie globalne błędy walidacji
        int i = 1;
        for (ObjectError error : bindingResult.getGlobalErrors()) {
            errorMap.put("global-error-"+i++, messageSource.getMessage(error.getCode(), error.getArguments(), locale));
        }

        return errorMap;
    }
}
