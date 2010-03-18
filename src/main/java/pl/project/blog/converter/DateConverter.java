package pl.project.blog.converter;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.TimeZone;
import org.svenson.converter.TypeConverter;

/**
 *
 * @author Jarosław Bela
 */
public class DateConverter implements TypeConverter {

    public static final String DEFAULT_FORMAT = "yyyy-MM-dd'T'HH:mm:ss";
    public static final String DEFAULT_TIMEZONE = "GMT";
    //
    private String format;
    private TimeZone timeZone;

    public DateConverter() {
        this(null, null);
    }

    public DateConverter(String format) {
        this(format, null);
    }

    public DateConverter(String format, TimeZone timeZone) {
        setFormat(format);
        setTimeZone(timeZone);
    }

    public void setFormat(String format) {
        if (format == null) {
            format = DEFAULT_FORMAT;
        }
        this.format = format;
    }

    public void setTimeZone(TimeZone timeZone) {
        if (timeZone == null) {
            timeZone = TimeZone.getTimeZone(DEFAULT_TIMEZONE);
        }
        this.timeZone = timeZone;
    }

    private SimpleDateFormat createFormat() {
        SimpleDateFormat sdf = new SimpleDateFormat(format);
        sdf.setTimeZone(timeZone);
        return sdf;
    }

    public Object fromJSON(Object in) {
        if (in == null) {
            return in;
        }
        
        if (in instanceof List) {
            List<Long> values = (List<Long>) in;

            Calendar calendar = Calendar.getInstance(timeZone);
            calendar.set(Calendar.YEAR, values.get(0).intValue());
            calendar.set(Calendar.MONTH, values.get(1).intValue());
            calendar.set(Calendar.DAY_OF_MONTH, values.get(2).intValue());
            calendar.set(Calendar.HOUR_OF_DAY, values.get(3).intValue());
            calendar.set(Calendar.MINUTE, values.get(4).intValue());
            calendar.set(Calendar.SECOND, values.get(5).intValue());
            calendar.set(Calendar.MILLISECOND, values.get(6).intValue());

            return calendar.getTime();
        } else {
            throw new IllegalArgumentException("Parameter must be a List<Long>, was a " + in + " ( " + in.getClass() + ")");
        }
    }

    public Object toJSON(Object in) {
        if (in == null) {
            return null;
        }
        
        if (in instanceof Date) {
            Calendar calendar = Calendar.getInstance(timeZone);
            calendar.setTime((Date) in);

            return new Integer[]{
                        calendar.get(Calendar.YEAR), calendar.get(Calendar.MONTH),
                        calendar.get(Calendar.DAY_OF_MONTH), calendar.get(Calendar.HOUR_OF_DAY),
                        calendar.get(Calendar.MINUTE), calendar.get(Calendar.SECOND),
                        calendar.get(Calendar.MILLISECOND)};
        } else {
            throw new IllegalArgumentException("Parameter must be a java.util.Date, was a " + in);
        }
    }
}

