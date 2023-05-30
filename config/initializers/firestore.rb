require "google/cloud/firestore"

def firestore
  project_id = "echolestia"  # replace this with your Firestore project ID
  Google::Cloud::Firestore.new project_id: project_id
end
