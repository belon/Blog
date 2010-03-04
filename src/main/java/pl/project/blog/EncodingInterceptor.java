package pl.project.blog;

import java.io.UnsupportedEncodingException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.jcouchdb.util.ExceptionWrapper;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

/**
 * Forces the request to have a configured encoding if it does not have an encoding.
 * @author shelmberger
 *
 */
public class EncodingInterceptor implements HandlerInterceptor
{
    private String encoding = "UTF-8";
    
    /**
     * Encoding to enforce.
     * @param encoding
     */
    public void setEncoding(String encoding)
    {
        this.encoding = encoding;
    }

    public void afterCompletion(HttpServletRequest arg0, HttpServletResponse arg1, Object arg2,
        Exception arg3) throws Exception
    {
    }

    public void postHandle(HttpServletRequest arg0, HttpServletResponse arg1, Object arg2,
        ModelAndView arg3) throws Exception
    {
    }

    public boolean preHandle(HttpServletRequest request, HttpServletResponse arg1, Object arg2)
        throws Exception
    {
        if (request.getCharacterEncoding() == null)
        {
            try
            {
                request.setCharacterEncoding(encoding);
            }
            catch (UnsupportedEncodingException e)
            {
                throw ExceptionWrapper.wrap(e);
            }
        }
        return true;
    }

}
