import {
  Entity,
  PrimaryGeneratedColumn,
  Column,
} from 'typeorm';

@Entity('borrowings')
export class Borrowing {

  @PrimaryGeneratedColumn()
  id: number;

  @Column()
  memberName: string;

  @Column()
  bookTitle: string;

  @Column()
  borrowDate: string;

  @Column()
  status: string;
}