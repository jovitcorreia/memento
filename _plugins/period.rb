require 'date'

module Jekyll
	module Period
		module Filter
			def until(start_date, end_date = Date.today)
				start_date = Date.parse(start_date)
				end_date = Date.parse end_date rescue Date.today
				abbr_start_mon = Date::ABBR_MONTHNAMES[start_date.mon]
				abbr_end_mon = Date::ABBR_MONTHNAMES[end_date.mon]
				date_diff = (end_date.year * 12 + end_date.mon) - (start_date.year * 12 + start_date.mon)
				year_diff = date_diff.divmod(12)[0]
				mon_diff = date_diff.divmod(12)[1]
				mon_period = mon_diff == 11 ? "" : mon_diff < 1 && year_diff == 0 ? "2 mos" : "#{mon_diff + 1} mos"
				year_period = year_diff == 1 || mon_diff == 11 ? "1 yr" : year_diff <= 0 ? "" : "#{year_diff} yrs"
				return "#{abbr_start_mon} #{start_date.year} – #{end_date == Date.today ? "Present" : "#{abbr_end_mon} #{end_date.year}"} · #{year_period} #{mon_period}".squeeze(" ")
			end
		end
    end
end

Liquid::Template.register_filter(Jekyll::Period::Filter)