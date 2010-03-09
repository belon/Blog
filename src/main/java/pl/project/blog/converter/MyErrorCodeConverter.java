package pl.project.blog.converter;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springmodules.validation.bean.converter.ErrorCodeConverter;
import pl.project.blog.controller.BlogController;

/**
 *
 * @author Jarosław Bela
 */
public class MyErrorCodeConverter implements ErrorCodeConverter {

    private static Logger log = LoggerFactory.getLogger(BlogController.class);

    public String convertGlobalErrorCode(String errorCode, Class clazz) {
        log.error("Global %s %s", new Object[]{errorCode, clazz.getClass().getName()});
        return errorCode;
    }

    public String convertPropertyErrorCode(String errorCode, Class clazz, String propertyName) {
        System.out.println("Test " + errorCode);
        System.out.println("Test " + propertyName);
        log.error("Property %s %s %s", new Object[]{errorCode, clazz.getClass().getName(), propertyName});
        return errorCode;  // <------ use the errorCode only
    }

}
