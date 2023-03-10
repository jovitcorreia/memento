require 'jekyll'
require 'date'

module Jekyll
  module Period
    module Filter
      def until(start_date, end_date = Date.today)
        start_date = Date.parse(start_date) rescue Date.today
        end_date = Date.parse(end_date) rescue Date.today
        date_diff = (end_date.year * 12 + end_date.month) - (start_date.year * 12 + start_date.month)
        year_diff, mon_diff = date_diff.divmod(12)
        abbr_start_mon = Date::ABBR_MONTHNAMES[start_date.month]
        abbr_end_mon = Date::ABBR_MONTHNAMES[end_date.month]
        mon_period = mon_diff == 11 ? "" : mon_diff < 1 && year_diff == 0 ? "1 mo" : "#{mon_diff + 1} mos"
        year_period = year_diff <= 0 ? "" : year_diff == 1 || mon_diff == 11 ? "1 yr" : "#{year_diff} yrs"
        "#{abbr_start_mon} #{start_date.year} – #{end_date == Date.today ? "Present" : "#{abbr_end_mon} #{end_date.year}"} · #{year_period} #{mon_period}".squeeze(" ")
      end
    end
  end
end

Liquid::Template.register_filter(Jekyll::Period::Filter)
