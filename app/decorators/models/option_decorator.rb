Naturesoft::Option.class_eval do
  @areas = {
    "items_per_page" => 10,
    "thumbnails" => {
      "0" => {
        "code" => "big",
        "width" => "800",
        "height" => "533",
        "scale" => "fit"
      },
      "1" => {
        "code" => "medium",
        "width" => "500",
        "height" => "500",
        "scale" => "fill"
      },
      "2" => {
        "code" => "small",
        "width" => "80",
        "height" => "80",
        "scale" => "fill"
      }
    },
  }
end