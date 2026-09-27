defmodule HologramSkeleton.Cldr do
  use Cldr, locales: ["en"], default_locale: "en", providers: [Cldr.Number, Cldr.Calendar, Cldr.DateTime]
end
