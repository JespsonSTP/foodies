resource "aws_iam_role" "jenkins_role" {
  # The name of the role
  name = "jenkinsadmin"

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "eks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}



resource "aws_iam_role_policy_attachment" "jenkins_policy" {
  # The ARN of the policy you want to apply
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2FullAccess"

  # The role the policy should be applied to
  role = aws_iam_role.jenkins_role.name
}