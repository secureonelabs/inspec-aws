aws_cluster_names = attribute(:aws_cluster_name, value: '', description: '')
aws_service_arn = attribute( :aws_service_id, value: '', description: '')
aws_service_name = attribute(:aws_ecs_service_name, value: '', description: '')
aws_cluster_arn = attribute(:aws_cluster_arn, value: '', description: '')


control 'aws-ecs-services-1.0' do
    impact 1.0
    title 'Ensure AWS ECS Services has the correct properties.'
    describe aws_ecs_services(cluster: aws_cluster_names) do
      it { should exist }
    end
end

control 'aws-ecs-services-2.0' do
  impact 1.0
  title 'Ensure AWS ECS Services has the correct properties.'
  describe aws_ecs_services(cluster: aws_cluster_names) do
    its('service_names') { should include aws_service_name }
    its('service_arns') { should include aws_service_arn }
    its('cluster_arns') { should include aws_cluster_arn}
    its('status') { should include "ACTIVE" }
    its('desired_count') { should include 0 }
    its('pending_count') { should include 0 }
    its('launch_types') { should include "EC2" }
  end
end