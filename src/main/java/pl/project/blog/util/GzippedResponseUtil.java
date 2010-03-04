package pl.project.blog.util;

import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.OutputStream;
import java.util.zip.GZIPOutputStream;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.FileUtils;
import org.apache.log4j.Logger;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.Controller;

/**
 * Utility class to send gzipped data responses from a controller.
 * @author shelmberger
 *
 */
public class GzippedResponseUtil {

    protected static Logger log = Logger.getLogger(GzippedResponseUtil.class);

    private GzippedResponseUtil() {
    }

    public static boolean supportsGzip(HttpServletRequest request) {
        String accept = request.getHeader("Accept-Encoding");
        return (accept != null && accept.indexOf("gzip") >= 0);
    }

    public static void setGzipGzipEncoding(HttpServletResponse response) {
        response.setHeader("Content-Encoding", "gzip");
    }

    /**
     * Sends the given byte[] data as non-streamed gzip response if the client supports that. Sets
     * content-length header. Spring {@link Controller} need to return null as {@link ModelAndView}
     * .
     * @param request
     * @param response
     * @param data
     * @param tryTocompress if set to <code>true</code>, gzip compression will be used if the client supports that.
     * @throws IOException
     * @return the data sent
     */
    public static byte[] sendResponse(HttpServletRequest request, HttpServletResponse response, byte[] data, boolean tryTocompress) throws IOException {
        OutputStream out = null;
        boolean closeOutput = false;
        try {
            out = response.getOutputStream();
            if (tryTocompress) {
                if (supportsGzip(request)) {
                    setGzipGzipEncoding(response);
                    data = compress(data);
                }
            }
            response.setContentLength(data.length);
            out.write(data);
            return data;
        } catch (IOException e) {
            log.error("Error sending data", e);
            response.sendError(500);
            closeOutput = true;
            return null;
        } finally {
            if (out != null) {
                out.flush();
                if (closeOutput) {
                    out.close();
                }
            }
        }
    }

    public static byte[] compress(byte[] data) throws IOException {
        ByteArrayOutputStream bos = new ByteArrayOutputStream();
        GZIPOutputStream gzOut = null;
        try {
            gzOut = new GZIPOutputStream(bos);
            gzOut.write(data);
        } finally {
            if (gzOut != null) {
                gzOut.flush();
                gzOut.close();
            }
        }

        return bos.toByteArray();
    }

    /**
     * Creates a gzipped copy of the given file with the filename of the file
     * plus ".gz" if the gzipped copy does not exist or has an older lastModified
     * value and returns it.
     * @param file
     */
    public static File getGzippedCopy(File file) throws IOException {
        if (file == null) {
            throw new IllegalArgumentException("file can't be null");
        }
        if (!file.exists()) {
            throw new FileNotFoundException(file + " does not exist");
        }

        File gzipFile = new File(file.getPath() + ".gz");

        if (!gzipFile.exists() || gzipFile.lastModified() <= file.lastModified()) {
            byte[] data = FileUtils.readFileToByteArray(file);
            data = compress(data);
            FileUtils.writeByteArrayToFile(gzipFile, data);
        }

        return gzipFile;
    }
}
