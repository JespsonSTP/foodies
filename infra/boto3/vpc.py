import boto3


# Initialize a session using Boto3
ec2 = boto3.client('ec2')

# Step 1: Create a VPC
response = ec2.create_vpc(
    CidrBlock='10.0.0.0/16',
    InstanceTenancy='default',
    TagSpecifications=[
        {
            'ResourceType': 'vpc',
            'Tags': [
                {'Key': 'Name', 'Value': 'MyCustomVPC'}
            ]
        }
    ]
)

vpc_id = response['Vpc']['VpcId']
print(f"VPC Created: {vpc_id}")

# Step 2: Enable DNS support and hostnames
ec2.modify_vpc_attribute(VpcId=vpc_id, EnableDnsSupport={'Value': True})
ec2.modify_vpc_attribute(VpcId=vpc_id, EnableDnsHostnames={'Value': True})
print("Enabled DNS support and hostnames.")

# Step 3: Create a Subnet
subnet_response = ec2.create_subnet(
    VpcId=vpc_id,
    CidrBlock='10.0.1.0/24',
    TagSpecifications=[
        {
            'ResourceType': 'subnet',
            'Tags': [
                {'Key': 'Name', 'Value': 'MySubnet'}
            ]
        }
    ]
)
subnet_id = subnet_response['Subnet']['SubnetId']
print(f"Subnet Created: {subnet_id}")

# Step 4: Create an Internet Gateway
igw_response = ec2.create_internet_gateway(
    TagSpecifications=[
        {
            'ResourceType': 'internet-gateway',
            'Tags': [
                {'Key': 'Name', 'Value': 'MyInternetGateway'}
            ]
        }
    ]
)
igw_id = igw_response['InternetGateway']['InternetGatewayId']
print(f"Internet Gateway Created: {igw_id}")

# Step 5: Attach Internet Gateway to the VPC
ec2.attach_internet_gateway(InternetGatewayId=igw_id, VpcId=vpc_id)
print("Internet Gateway attached to the VPC.")

# Step 6: Create a Route Table
route_table_response = ec2.create_route_table(
    VpcId=vpc_id,
    TagSpecifications=[
        {
            'ResourceType': 'route-table',
            'Tags': [
                {'Key': 'Name', 'Value': 'MyRouteTable'}
            ]
        }
    ]
)
route_table_id = route_table_response['RouteTable']['RouteTableId']
print(f"Route Table Created: {route_table_id}")

# Step 7: Create a Route for Internet Access
ec2.create_route(
    RouteTableId=route_table_id,
    DestinationCidrBlock='0.0.0.0/0',
    GatewayId=igw_id
)
print("Route created for internet access.")

# Step 8: Associate the Subnet with the Route Table
ec2.associate_route_table(SubnetId=subnet_id, RouteTableId=route_table_id)
print("Subnet associated with Route Table.")

print("VPC and related resources created successfully.")