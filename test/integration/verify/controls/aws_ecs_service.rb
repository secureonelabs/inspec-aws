aws_cluster_name = attribute(:aws_cluster_name, value: '', description: '')
aws_service_arn = attribute( :aws_service_id, value: '', description: '')
aws_service_name = attribute(:aws_ecs_service_name, value: '', description: '')
aws_cluster_arn = attribute(:aws_cluster_arn, value: '', description: '')

control 'aws-ecs-service-1.0' do
  impact 1.0
  title 'Ensure AWS ECS Service has the correct properties.'

  describe aws_ecs_service(cluster: aws_cluster_name, services: aws_service_name ) do
      it { should exist }
  end
end

control 'aws-ecs-service-2.0' do
  impact 1.0
  title 'Ensure AWS ECS Service has the correct properties.'

  describe aws_ecs_service(cluster: aws_cluster_name, services: aws_service_name) do
      its('service_name') { should eq aws_service_name }
      its('service_arn') { should eq aws_service_arn }
      its('cluster_arn') { should eq aws_cluster_arn}
      its('status') { should eq "ACTIVE" }
      its('desired_count') { should eq 0 }
      its('pending_count') { should eq 0 }
      its('launch_type') { should eq "EC2" }
  end
end

