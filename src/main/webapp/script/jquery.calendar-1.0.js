// jQuery Month Calendar Plugin 1.0 Copyright 2009 Jarrett Vance http://jvance.com/pages/jQueryMonthCalPlugin.xhtml
(function ($) {
  $.fn.calendar = function (options) {
    var opts = $.extend({}, $.fn.calendar.defaults, options);
    return this.each(function () {
      var $this = $(this);
      $this.find('td')
        .hover(function () { $(this).addClass('hover') }, function () { $(this).removeClass('hover') })
        .click(function () { return changeDay($this, $(this), new Date($(this).find('a').attr('title')), opts); });
      $this.find('a[rel=prev], a[rel=next]').click(function () {
        changeMonth($this, opts, ($(this).attr('rel') == 'next'));
        return false;
      });
      refreshCal($this, opts);
    });
  }

  function changeMonth($cal, opts, next) {
    if (next && opts.month == 11) {
      opts.year = opts.year + 1;
      opts.month = 0;
    } else if (!next && opts.month == 0) {
      opts.year = opts.year - 1;
      opts.month = 11;
    } else {
      opts.month = next ? opts.month + 1 : opts.month - 1;
    }
    refreshCal($cal, opts);
  }

  function changeDay($cal, $cell, date, opts) {
    opts.current = date;
    opts.year = date.getFullYear();
    opts.month = date.getMonth();
    refreshCal($cal, opts);
    //allow outside cancel
    return opts.dateChanged(date);
  };

  function refreshCal($cal, opts) {
    var monthNames = ['Styczeń', 'Luty', 'Marzec', 'Kwiecień', 'Maj', 'Czerwiec', 'Lipiec', 'Sierpień', 'Wrzesień', 'Październik', 'Listopad', 'Grudzień'];
    $cal.find('.month').text(monthNames[opts.month] + ' ' + opts.year);
    $cal.find('td').removeClass('out').removeClass('today').removeClass('current');
    var days = getDaysInMonthForDate(opts.year, opts.month, opts.current);
    var tds = $cal.find('td');
    for (j = 0; j < 42; j++) {
      $(tds[j]).find('a').text(days[j].date.getDate())
        .attr('title', days[j].date.toDateString())
        .attr('href', getUrl(days[j].date, opts));
      if (days[j].out) $(tds[j]).addClass('out');
      if (days[j].current) $(tds[j]).addClass('current');
      if (days[j].today) $(tds[j]).addClass('today');
    }
  }

  function getUrl(date, opts) {
    var url = opts.templateUrl;
    url = url.replace(opts.templateYear, date.getFullYear());
    url = url.replace(opts.templateMonth, ((date.getMonth() + 1) < 10 ? "0" : "") + (date.getMonth() + 1));
    url = url.replace(opts.templateDay, (date.getDate() < 10 ? "0" : "") + date.getDate());
    return url;
  }


  function getDaysInMonthForDate(year, month, current) {
    var today = new Date();
    var first = new Date(year, month, 1);
    first.setDate(first.getDate() - first.getDay());

    var days = new Array(42);
    for (j = 0; j < 42; j++) {
      var d = new Date(first);
      d.setDate(first.getDate() + j);
      days[j] = {
        date: d,
        out: !(d.getFullYear() == year && d.getMonth() == month),
        today: d.getFullYear() == today.getFullYear() && d.getMonth() == today.getMonth() && d.getDate() == today.getDate(),
        current: d.getFullYear() == current.getFullYear() && d.getMonth() == current.getMonth() && d.getDate() == current.getDate()
      }
    }
    return days;
  };

  $.fn.calendar.defaults = {
    current: new Date(),
    year: new Date().getFullYear(),
    month: new Date().getMonth(),
    templateYear: 'year',
    templateMonth: 'month',
    templateDay: 'day',
    templateUrl: '/year-month-day',
    dateChanged: function (date) { return true; }
  };
})(jQuery);