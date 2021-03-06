module RiCal
  class PropertyValue
    class RecurrenceRule < PropertyValue
      #- c2009 Rick DeNatale, All rights reserved. Refer to the file README.txt for the license
      #
      class OccurrenceIncrementer # :nodoc:
        class ByMonthdayIncrementer < ByNumberedDayIncrementer #:nodoc:
          def self.for_rrule(rrule)
            conditional_incrementer(rrule, :bymonthday, DailyIncrementer)
          end

          def scope_of(date_time)
            date_time.month
          end

          def start_of_cycle(date_time)
            date_time.change(:day => 1)
          end

          def advance_cycle(date_time)
            first_day_of_month(advance_month(date_time))
          end

          def occurrences_for(date_time)
            @scoping_value = scope_of(date_time)
            self.occurrences = list.map {|numbered_day| numbered_day.target_date_time_for(date_time)}.uniq.sort
          end

          def end_of_occurrence(date_time)
            date_time.end_of_day
          end
        end
      end
    end
  end
end
