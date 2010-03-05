package pl.project.blog.util;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.View;
import org.svenson.JSON;
import org.svenson.JSONable;

/**
 * JSON-View Implementation that converts a java model to JSON and sends
 * that as response, optionally gzip-compressed.
 *
 * @see JSON
 * @see JSONable
 * @author shelmberger
 */
public class JSONView implements View {

    private Object model;
    private boolean compress;
    private JSON jsonGenerator;

    public JSONView(Object model) {
        this(model, false, null);
    }

    public JSONView(Object model, boolean compress) {
        this(model, compress, null);
    }

    public JSONView(Object model, boolean compress, JSON jsonGenerator) {
        this.model = model;
        this.compress = compress;
        this.jsonGenerator = jsonGenerator == null ? JSON.defaultJSON() : jsonGenerator;
    }

    public void render(Map model, HttpServletRequest request, HttpServletResponse response) throws Exception {
        String json = jsonGenerator.dumpObjectFormatted(this.model);
        byte[] data = json.getBytes(response.getCharacterEncoding());
        GzippedResponseUtil.sendResponse(request, response, data, compress);
    }

    public static ModelAndView modelAndView(Object model) {
        return new ModelAndView(new JSONView(model));
    }

    public static ModelAndView modelAndView(Object model, boolean compress) {
        return new ModelAndView(new JSONView(model, compress));
    }

    public static ModelAndView modelAndView(Object model, boolean compress, JSON jsonGenerator) {
        return new ModelAndView(new JSONView(model, compress, jsonGenerator));
    }

    public String getContentType() {
        return "application/json";
    }
}
