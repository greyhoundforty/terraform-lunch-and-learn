output "qa_ips" {
    value =  module.classic_instance["qa"].instance_ips
}

output "bucket_locations" {
    value = module.object_storage.location
}