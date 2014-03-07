json.array!(@steps) do |step|
  json.extract! step, :id, :shortcut_id, :step_number, :text, :image_url
  json.url step_url(step, format: :json)
end
