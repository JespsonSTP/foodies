resource "aws_eks_cluster" "eks" {
  # Name of the cluster.
  name = "eks"

  # The Amazon Resource Name (ARN) of the IAM role that provides permissions for 
  # the Kubernetes control plane to make calls to AWS API operations on your behalf
  role_arn = aws_iam_role.eks_cluster.arn

  # Desired Kubernetes master version
  version = "1.31"

  vpc_config {
    # Indicates whether or not the Amazon EKS private API server endpoint is enabled
    #endpoint_private_access = false

    # Indicates whether or not the Amazon EKS public API server endpoint is enabled
    endpoint_public_access = true

    # Must be in at least two different availability zones
    subnet_ids = [
      aws_subnet.pub_sub1.id,
      aws_subnet.pub_sub2.id,
      aws_subnet.eks_sub1.id,
      aws_subnet.eks_sub2.id
    ]
  }

  # Ensure that IAM Role permissions are created before and deleted after EKS Cluster handling.
  # Otherwise, EKS will not be able to properly delete EKS managed EC2 infrastructure such as Security Groups.
  depends_on = [
    aws_iam_role_policy_attachment.amazon_eks_cluster_policy
  ]
}