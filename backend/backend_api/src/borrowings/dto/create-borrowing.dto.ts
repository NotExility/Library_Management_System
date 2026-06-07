import { IsString } from 'class-validator';

export class CreateBorrowingDto {

  @IsString()
  memberName: string;

  @IsString()
  bookTitle: string;

  @IsString()
  borrowDate: string;

  @IsString()
  status: string;
}