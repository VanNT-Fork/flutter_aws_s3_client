import 'package:flutter_aws_s3_client/flutter_aws_s3_client.dart';

void main() async {
  await main2();
  // const region = "us-east-1";
  // const bucketId = "minio-prepdoc";
  // final AwsS3Client s3client = AwsS3Client(
  //   region: region,
  //   host: "play.min.io",
  //   bucketId: bucketId,
  //   accessKey: '6tAKtJahPeOOfns4',
  //   secretKey: 'QgVnePmaMajM5AamUh0rYJd49Bo5YvXb',
  // );

  // final listBucketResult = await s3client.listObjects(delimiter: "/");
  // print(listBucketResult.toString());

  // final response =
  //     await s3client.getObject(listBucketResult.contents.first.key);
  // print(response.body.toString());
}

void main2() async {
  const region = "us-east-1";

  final AwsS3Client s3client = AwsS3Client(
    region: region,
    host: 'play.min.io',
    bucketId: 'minio-prepdoc',
    accessKey: '6tAKtJahPeOOfns4',
    secretKey: 'QgVnePmaMajM5AamUh0rYJd49Bo5YvXb',
  );

// make server encryption headers (sse-c)
  final ssecHeaders = {
    'X-Amz-Server-Side-Encryption-Customer-Algorithm': 'AES256',
    'X-Amz-Server-Side-Encryption-Customer-Key':
        'MzJieXRlc2xvbmdzZWNyZXRrZXltdXN0cHJvdmlkZWQ=',
    'X-Amz-Server-Side-Encryption-Customer-Key-MD5': '7PpPLAK26ONlVUGOWlusfg=='
  };
  // try connecting to the server and getting credentials object storage
  final stream =
      await s3client.getObject('test-sse-c-1.txt', headers: ssecHeaders);

  // Get object length
  print(stream.contentLength);

  print(stream.body.toString());
}
